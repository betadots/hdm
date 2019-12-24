import React from "react"
import PropTypes from "prop-types"
import Button from '@material-ui/core/Button'
import { hot } from 'react-hot-loader/root'
import { withStyles } from '@material-ui/core/styles';
import { wrapper } from "reativo"
import Menu from "./Menu"

const styles = theme => ({
  root: {
    paddingBottom: 10
  },
})

class Drawer extends React.Component {
  render () {
    const { classes } = this.props;
    return (
      <div className={classes.root}>
        <Menu />
      </div>
    );
  }
}

Drawer.propTypes = {
  classes: PropTypes.object.isRequired,
};


function mapStateToProps (state) {
  return {
    drawer: state.drawer
  }
}

function mapDispatchToProps (dispatch) {
  return {
    toggle: () => {
      dispatch({type: "DRAWER_TOGGLE"})
    },
  }
}

export default hot(
  withStyles(styles)(
    wrapper(Drawer, mapStateToProps, mapDispatchToProps)
  )
)

