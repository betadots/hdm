import { hot } from 'react-hot-loader/root'
import React from 'react';

import { wrapper } from "reativo"

import Dialog from '@material-ui/core/Dialog';
import DialogContent from '@material-ui/core/DialogContent';
import DialogContentText from '@material-ui/core/DialogContentText';
import DialogTitle from '@material-ui/core/DialogTitle';

function Show({model, error, classes}) {
  return (
    <div>
      <Dialog
        open={true}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        <DialogTitle id="alert-dialog-title">{"HDM Error"}</DialogTitle>
        <DialogContent>
          <DialogContentText id="alert-dialog-description">
            {error}
          </DialogContentText>
        </DialogContent>
      </Dialog>
    </div>
  );
}

export default hot(wrapper(Show));
