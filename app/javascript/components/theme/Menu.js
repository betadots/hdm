// React Imports
import React from 'react'
import PropTypes from 'prop-types'

import { withStyles } from '@material-ui/core/styles'
import classNames from 'classnames'
import ListItem from '@material-ui/core/ListItem'
import HomeIcon from '@material-ui/icons/Home'

import { hot } from 'react-hot-loader/root'
import { wrapper } from "reativo"

const styles = theme => ({
  //css buttons
  button: {
    width: '100%',
    maxWidth: 360,
    backgroundColor: theme.palette.background.paper,
    borderRadius: '0 12px 12px 0',
    transition: 'margin .15s cubic-bezier(0.4,0.0,0.2,1),padding .15s cubic-bezier(0.4,0.0,0.2,1)',
    padding: '0 10px 0 26px',

    '&:hover': {
      cursor: 'pointer',
    },
  //css on specifc divs
  },
  divRoot: {
    padding: '0 8px 0 26px',
    alignItems: 'center',
    display: 'flex',
    height: '24px',
    position: 'relative'
  },
  divIcon: {
    borderColor: '#000',
    alignItems: 'center',
    display: 'flex',
    flexShrink: '0',
    height: '20px',
    justifyContent: 'flex-start',
    marginRight: '18px',
    width: '20px',
    color: '#767676',
  },
});


const menuItems = [
  {icon: HomeIcon, text: "Editor", url: "/"},
]

function SimpleList({classes, drawer}) {
  return (
    <div id="menu-list" data-turbolinks-permanent>
      {menuItems.map((item, index) => (
        <ListItem key={index} button className={classNames(classes.button,classes.divRoot)} onClick={() => Turbolinks.visit(item.url)}>
          <item.icon className={classes.divIcon}/>
            {drawer.open ? item.text : ''}
        </ListItem>
      ))} 
    </div>
  );
}

SimpleList.propTypes = {
  classes: PropTypes.object.isRequired,
};

const mapStateToProps = state => {
  const { drawer } = state
  return ({
    drawer
  })
}

export default hot(withStyles(styles)(
  wrapper(SimpleList, mapStateToProps)
))
