import React, { useState } from 'react'
import ExpansionPanel from '@material-ui/core/ExpansionPanel'
import ExpansionPanelSummary from '@material-ui/core/ExpansionPanelSummary'
import ExpansionPanelDetails from '@material-ui/core/ExpansionPanelDetails'
import ExpansionPanelActions from '@material-ui/core/ExpansionPanelActions'
import TextField from '@material-ui/core/TextField'
import Divider from '@material-ui/core/Divider'
import Button from '@material-ui/core/Button'
import ExpandMoreIcon from '@material-ui/icons/ExpandMore'
import Typography from '@material-ui/core/Typography'
import axios from 'axios'
import { withSnackbar } from 'notistack'
import { withStyles } from "@material-ui/core/styles";

const styles = theme => ({
  heading: {
    fontSize: theme.typography.pxToRem(15),
    fontWeight: theme.typography.fontWeightRegular
  },
  editablePresent: {
    border: "solid 1px blue",
    "& div > div > p": {
      fontWeight: "600 !important"
    }
  },
  editableNoKey: {
    border: "solid 1px black",
    "& div > div > p": {
      fontStyle: "italic",
    }
  },
  editableNoFile: {
    border: "solid 1px gray",
    "& div > div > p": {
      fontStyle: "italic",
      color: "gray"
    }
  },
  textField: {
    width: "100%"
  }
});

function Editable({ classes, model, hierarchy, file, enqueueSnackbar }) {
  const [defaultValue, setDefaultValue] = useState(file.value || '');
  const [value, setValue] = useState(file.value || '');
  const [present, setPresent] = useState(file.present || false);
  const [keyPresent, setKeyPresent] = useState(file.key_present || false);
  const [created, setCreated] = useState(false);
  const [error, setError] = useState(null)

  const selectColor = () => {
    if (status() == "no_key") {
      return ("textSecondary")
    }

    return ("textPrimary")
  }

  const handleChange = (e) => {
    setValue(e.target.value)
    setError(null)
  }

  const saveChanges = (value) => {
    if (value === "") {
      enqueueSnackbar('Please fill the value')
    } else {
      const meta_csrf = document.querySelector("meta[name=csrf-token]")
      axios({
        method: "patch",
        url: `${window.location.href}`,
        data: {
          path: file.path,
          value: value
        },
        headers: {
          'Accept': 'application/json',
          'X-CSRF-Token': (meta_csrf ? meta_csrf.content : null)
        }
      })
        .then(function (response) {
          enqueueSnackbar('Saved')
          setDefaultValue(value)
          setCreated(true)
        })
        .catch(function (error) {
          try {
            if (error.response) {
              setError(error.response.data.errors.value[0])
            }
          } catch (error) {
            enqueueSnackbar('Oops, something went wrong')
          }
        })
    }
  }

  const removeValue = () => {
    const meta_csrf = document.querySelector("meta[name=csrf-token]")
    axios({
      method: "delete",
      url: `${window.location.href}`,
      data: {
        path: file.path,
      },
      headers: {
        'Accept': 'application/json',
        'X-CSRF-Token': (meta_csrf ? meta_csrf.content : null)
      }
    })
      .then(function (response) {
        enqueueSnackbar('Removed')
        setDefaultValue("")
        setValue("")
        setCreated(false)
        setPresent(false)
        setKeyPresent(false)
      })
      .catch(function (error) {
        enqueueSnackbar('Oops, something went wrong')
      })
  }

  const status = () => {
    if (created) {
      return "editablePresent"
    } else if (!present) {
      return "editableNoFile"
    } else if (!keyPresent) {
      return "editableNoKey"
    } else {
      return "editablePresent"
    }
  }

  const statusClassName = (classes) => {
    return classes[status()];
  }

  return (
    <ExpansionPanel className={statusClassName(classes)}>
      <ExpansionPanelSummary expandIcon={<ExpandMoreIcon />}>
        <Typography className={classes.heading}>{file.path}</Typography>
      </ExpansionPanelSummary>
      <ExpansionPanelDetails>
        <TextField
          error={error ? true : false}
          helperText={error ? error : ''}
          id="outlined-multiline-static"
          label='Value'
          multiline
          rows="8"
          value={value}
          onChange={(e) => handleChange(e)}
          className={classes.textField}
          margin="normal"
          variant="outlined"
        />
      </ExpansionPanelDetails>
      <Divider />
      <ExpansionPanelActions>
        {(status() == "editablePresent") &&
          <Button size="small" onClick={() => removeValue()} color="secondary">Remove Value</Button>
        }
        <Button size="small" onClick={() => setValue(defaultValue)}>Cancel</Button>
        <Button size="small" onClick={() => saveChanges(value)} color="primary">Save</Button>
      </ExpansionPanelActions>
    </ExpansionPanel>
  )
}

export default withSnackbar(withStyles(styles)(Editable))
