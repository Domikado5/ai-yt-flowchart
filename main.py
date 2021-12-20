import clips
from flask import Flask, render_template
from flask_socketio import SocketIO, send, emit
import socketio
import sqlite3

class UI:
    def __init__(self, clips_path: str, ):
        # Create CLIPS environment
        self.env = clips.Environment()
        # Load CLIPS file
        self.env.load(clips_path)
        # Reset CLIPS - (reset)
        self.env.reset()
        self.choices = [] # valid answers
        self.selected = "" # default selection
        self.label = "" # display message
        self.state = "" # state

    def next_ui_state(self):
        eval_string = "(find-all-facts ((?f state-list)) TRUE)"
        eval_object = self.env.eval(eval_string)[0]
        current_id = dict(eval_object)["current"]

        eval_string = "(find-all-facts ((?f UI-state)) " + "(eq ?f:id " + current_id + "))"
            
        fv = self.env.eval(eval_string)[0]

        # UI changes buttons etc.
        self.state = dict(fv)["state"]

        # logic
        pv = dict(fv)["valid-answers"]
        self.selected = dict(fv)["response"]

        self.choices.clear()
        for i in range(len(pv)):
            bv = pv[i]
            self.choices.append(pv[i])


            # create radio button

        #  Set up label
        text = dict(fv)["display"]
        self.label = text

    def action(self, action: str, response: str):
        eval_string = "(find-all-facts ((?f state-list)) TRUE)"
        eval_object = self.env.eval(eval_string)[0]
        current_id = dict(eval_object)["current"]
        eval_string = "(find-all-facts ((?f UI-state)) " + "(eq ?f:id " + current_id + "))"
        print(f"{action}, {response}")
        fv = self.env.eval(eval_string)[0]
        if action == "next" and dict(fv)["state"] != "initial":
            eval_string = f"(assert (next {current_id} {response}))"
            self.env.eval(eval_string)
        elif action == "previous" and dict(fv)["state"] != "initial":
            eval_string = f"(assert (prev {current_id}))"
            self.env.eval(eval_string)
        elif action == "next" and dict(fv)["state"] == "initial":
            eval_string = f"(assert (next {current_id}))"
            self.env.eval(eval_string)
        elif action == "reset":
            self.env.reset()
        self.run()
    def run(self):
        self.env.run()
        self.next_ui_state()

ui = UI("./yt-big-data.clp")
ui.run()

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
app.config['DEBUG'] = True
socketio = SocketIO(app)

@app.route('/')
def index():
    return render_template('index.html')

@socketio.on('connect')
def test_connect():

    emit('connected', {'data': 'Server: Connected'})

@socketio.on('connected')
def connected(json):
    print(str(json))
    emit('reload', {'label': ui.label, 'choices': ui.choices, 'selected': ui.selected, 'state': ui.state})

@socketio.on('disconnect')
def test_disconnect():
    print('Client disconnected')

@socketio.on('action')
def handle_next(json):
    ui.action(json['action'], json['answer'])
    emit('reload', {'label': ui.label, 'choices': ui.choices, 'selected': ui.selected, 'state': ui.state})

if __name__ == '__main__':
    socketio.run(app)