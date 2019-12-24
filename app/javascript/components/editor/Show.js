import { hot } from 'react-hot-loader/root'
import React from 'react'

import {
  Typography,
  Button,
} from '@material-ui/core'

import { wrapper } from "reativo"

function Show({model}) {
  const { id } = model

  return (
    <div style={{ padding: 16, margin: 'auto', maxWidth: 600 }}>
      <Typography variant="h4" align="center" component="h1" gutterBottom>
        Editor
      </Typography>
      <Button variant="contained" color="primary" href={`/editor/${id}/edit`}>
        Edit
      </Button>
      <Button variant="contained" color="secondary" href="/editor">
        Back to Editors
      </Button>
    </div>
  );
}

export default hot(wrapper(Show))
