import React, { Component } from 'react';
// import { connect } from 'react-redux';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

import {
    TextField,
    RaisedButton,
    Dialog,
    Checkbox
} from 'material-ui';

class Login extends Component {
    state = {
        open: false,
        checked: false,
        email: '',
        password: ''
    };
    handleOpen = () => {
        this.setState({open: true});
    };
    handleClose = () => {
        this.setState({open: false});
    };
    updateCheck() {
        this.setState((oldState) => {
            return {
                checked: !oldState.checked,
            };
        });
    }

    submitForm(){
        console.log('login form submitted');
    }

    render(){
        const actions = [
            <RaisedButton
                label="Cancel"
                onClick={this.handleClose}
                secondary={true}
            />,
            <RaisedButton
                label="Submit"
                onClick={this.submitForm}
                secondary={true}
            />,
        ];
        return (
            <MuiThemeProvider>
                <RaisedButton
                    label="Login"
                    onClick={this.handleOpen}
                    secondary={true}
                />
                <Dialog
                    title="Sign In To e-comm "
                    actions={actions}
                    modal={true}
                    open={this.state.open}
                >
                    <TextField
                        floatingLabelText="Username or Email"
                        fullWidth={true}
                    /><br />
                    <TextField
                        type="password"
                        floatingLabelText="Password"
                        fullWidth={true}
                    /><br />
                    <Checkbox
                        label="Remember Me"
                        checked={this.state.checked}
                        onCheck={this.updateCheck.bind(this)}
                    />
                </Dialog>
            </MuiThemeProvider>
        )
    }
}
function mapStateToProps(state){
    return {
        count: state.counterReducer,
    };
}
export default Login;
