import { hot } from 'react-hot-loader/root'
import React from 'react'

import {
  Typography,
  Button,
} from '@material-ui/core'
import Form from './Form'
import { Form as FinalForm } from 'react-final-form'
import { validate } from './Form'
import { RailsForm } from 'reativo'
import { wrapper } from "reativo"

function Edit({model}) {
  return (
    <div style={{ padding: 16, margin: 'auto', maxWidth: 600 }}>
      <Typography variant="h4" align="center" component="h1" gutterBottom>
        Edit Editor
      </Typography>
      <RailsForm
        component={FinalForm}
        action='update'
        url={`/editor/${model.id}`}
        successUrl={`/editor/${model.id}`}
        validate={validate}
        render={(props) => (
          <Form {...props} />
        )}
      />
      <Button variant="contained" color="secondary" href="/editor">
        Back to Editors
      </Button>
    </div>
  );
}

export default hot(wrapper(Edit))
