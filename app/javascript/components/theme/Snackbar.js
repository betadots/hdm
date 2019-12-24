import React from 'react';
import { Snackbar as SnackbarOriginal } from "reativo"
import { wrapper } from "reativo"

function Snackbar({messages}) {
  return <SnackbarOriginal messages={messages} />
}

export default wrapper(Snackbar)
