import React from 'react'

import { Field } from 'react-final-form'
import { TextField } from 'final-form-material-ui'
import {
  Paper,
  Grid,
  Button,
} from '@material-ui/core';

export const validate = values => {
  // const errors = {};
  // if (!values.name) {
  //   errors.name = 'Required';
  // }
  // return errors;
};

function Form({ handleSubmit, reset, submitting, pristine, values }) {
  return (
    <form onSubmit={handleSubmit}>
      <Paper style={{ padding: 16 }}>
        <Grid container alignItems="flex-start" spacing={8}>
          <Grid item style={{ marginTop: 16 }}>
            <Button
              variant="contained"
              color="primary"
              type="submit"
              disabled={submitting}
              onClick={(e) => handleSubmit(e)}
            >
              Submit
            </Button>
          </Grid>
        </Grid>
      </Paper>
    </form>
  );
}

export default Form;