import React from 'react';
import PropTypes from 'prop-types';
import classNames from 'classnames';
// import Select from 'react-select';
import Select from 'react-select/lib/Async'
import { withStyles } from '@material-ui/core/styles';
import Typography from '@material-ui/core/Typography';
import NoSsr from '@material-ui/core/NoSsr';
import TextField from '@material-ui/core/TextField';
import Paper from '@material-ui/core/Paper';
import Chip from '@material-ui/core/Chip';
import MenuItem from '@material-ui/core/MenuItem';
import CancelIcon from '@material-ui/icons/Cancel';
import { emphasize } from '@material-ui/core/styles/colorManipulator';
import axios from 'axios'
import { debounce } from 'lodash-es'
import Button from '@material-ui/core/Button';
import { DatePicker } from "material-ui-pickers";
import format from 'date-fns/format'

const loadFromApi = (inputValue, callback) => {
  axios.get(`/admin/sensors.json?q=${inputValue}`)
  .then(function (response) {
    // handle success
    const results = response.data.map(x => {
      const label = `${x.module_label} (${x.xbee} - #${x.id})`
      return { value: x.id, label: label}
    })
    callback(results)
  })
}
const loadOptions = (inputValue, callback) => {
  loadFromApi(inputValue, callback)
};

const styles = theme => ({
  root: {
    flexGrow: 1,
    height: 250,
  },
  input: {
    display: 'flex',
    padding: 0,
  },
  valueContainer: {
    display: 'flex',
    flexWrap: 'wrap',
    flex: 1,
    alignItems: 'center',
    overflow: 'hidden',
  },
  noOptionsMessage: {
    padding: `${theme.spacing.unit}px ${theme.spacing.unit * 2}px`,
  },
  singleValue: {
    fontSize: 16,
  },
  placeholder: {
    position: 'absolute',
    left: 2,
    fontSize: 16,
  },
  paper: {
    position: 'absolute',
    zIndex: 1,
    marginTop: theme.spacing.unit,
    left: 0,
    right: 0,
  },
  divider: {
    height: theme.spacing.unit * 2,
  },
});

function NoOptionsMessage(props) {
  return (
    <Typography
      color="textSecondary"
      className={props.selectProps.classes.noOptionsMessage}
      {...props.innerProps}
    >
      {props.children}
    </Typography>
  );
}

function inputComponent({ inputRef, ...props }) {
  return <div ref={inputRef} {...props} />;
}

function Control(props) {
  return (
    <TextField
      fullWidth
      InputProps={{
        inputComponent,
        inputProps: {
          className: props.selectProps.classes.input,
          inputRef: props.innerRef,
          children: props.children,
          ...props.innerProps,
        },
      }}
      {...props.selectProps.textFieldProps}
    />
  );
}

function Option(props) {
  return (
    <MenuItem
      buttonRef={props.innerRef}
      selected={props.isFocused}
      component="div"
      style={{
        fontWeight: props.isSelected ? 500 : 400,
      }}
      {...props.innerProps}
    >
      {props.children}
    </MenuItem>
  );
}

function Placeholder(props) {
  return (
    <Typography
      color="textSecondary"
      className={props.selectProps.classes.placeholder}
      {...props.innerProps}
    >
      {props.children}
    </Typography>
  );
}

function SingleValue(props) {
  return (
    <Typography className={props.selectProps.classes.singleValue} {...props.innerProps}>
      {props.children}
    </Typography>
  );
}

function ValueContainer(props) {
  return <div className={props.selectProps.classes.valueContainer}>{props.children}</div>;
}

function MultiValue(props) {
  return (
    <Chip
      tabIndex={-1}
      label={props.children}
      className={classNames(props.selectProps.classes.chip, {
        [props.selectProps.classes.chipFocused]: props.isFocused,
      })}
      onDelete={props.removeProps.onClick}
      deleteIcon={<CancelIcon {...props.removeProps} />}
    />
  );
}

function Menu(props) {
  return (
    <Paper square className={props.selectProps.classes.paper} {...props.innerProps}>
      {props.children}
    </Paper>
  );
}

const components = {
  Control,
  Menu,
  MultiValue,
  NoOptionsMessage,
  Option,
  Placeholder,
  SingleValue,
  ValueContainer,
};

class IntegrationReactSelect extends React.Component {
  state = {
    single: null,
    date: (new Date())
  };

  handleChange = value => {
    this.setState({
      single: value,
    });
  };

  handleClick = e => {
    const sensor = this.state.single
    if(sensor == null) {
      window.alert('Hey, choose a sensor')
    } else {
      const date = format(this.state.date, "yyyy-MM-dd")
      const url = `/admin/data_management/sensor_data_v1?sensor_id=${sensor.value}&from=${date}`
      Turbolinks.visit(url)
    }
  }

  selectedDate = () => {
    return this.state.date
  }

  handleDateChange = (e) => {
    return this.setState({date: e})
  }

  render() {
    const { classes, theme } = this.props;

    const selectStyles = {
      input: base => ({
        ...base,
        color: theme.palette.text.primary,
        '& input': {
          font: 'inherit',
        },
      }),
    };

    return (
      <div className={classes.root}>
        <Paper style={{padding: 40}}>
          <NoSsr>
            <Select
              classes={classes}
              styles={selectStyles}
              components={components}
              value={this.state.single}
              onChange={this.handleChange}
              cacheOptions
              loadOptions={debounce(loadOptions, 250)}
              placeholder="Select a sensor module registry (xbee or label)..."
              isClearable
            />
            <br />
            <DatePicker
              keyboard
              label="Masked input"
              format={"MM/dd/yyyy"}
              placeholder="01/31/2019"
              mask={value =>
                // handle clearing outside if value can be changed outside of the component
                value ? [/\d/, /\d/, "/", /\d/, /\d/, "/", /\d/, /\d/, /\d/, /\d/] : []
              }
              value={this.state.date}
              onChange={this.handleDateChange}
              disableOpenOnEnter
              animateYearScrolling={false}
            />
            <br />
            <br />
            <Button variant="contained" color="secondary" onClick={this.handleClick}>See Data</Button>
          </NoSsr>
        </Paper>
      </div>
    );
  }
}

IntegrationReactSelect.propTypes = {
  classes: PropTypes.object.isRequired,
  theme: PropTypes.object.isRequired,
};

export default withStyles(styles, { withTheme: true })(IntegrationReactSelect);