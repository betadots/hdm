import React from 'react';
import Typography from '@material-ui/core/Typography';
import {withStyles } from '@material-ui/core/styles';
import Link from '@material-ui/core/Link';

function Copyright() {
  return (
    <Typography variant="body2" color="textSecondary">
      {'© example42 GmbH 2019-'}
      {new Date().getFullYear()}
      {' '}
      <Link color="inherit" href="https://example42.com/">
        example42.com
      </Link>
    </Typography>
  );
}

const styles = theme => ({
  footer: {
    display: 'block',
    position: 'absolute',
    bottom: 0,
    width: '100%',
    padding: `${theme.spacing.unit * 3}px ${theme.spacing.unit * 2}px`,
    backgroundColor:
      theme.palette.type === 'dark' ? theme.palette.grey[800] : theme.palette.grey[200],
  },
  container: {
    width: 'max-content',
    maxWidth: theme.breakpoints.values.sm,
    boxSizing: 'border-box',
    marginLeft: 'auto',
    marginRight: 'auto',
    paddingLeft: theme.spacing.unit * 2,
    paddingRight: theme.spacing.unit * 2,
    [theme.breakpoints.up('sm')]: {
      paddingLeft: theme.spacing.unit * 3,
      paddingRight: theme.spacing.unit * 3,
    },
    [theme.breakpoints.up('md')]: {
      paddingLeft: theme.spacing.unit * 4,
      paddingRight: theme.spacing.unit * 4,
    },
  },
});

function StickyFooter({ classes }) {
  return (
    <footer className={classes.footer}>
      <div className={classes.container}>
        <Copyright />
      </div>
    </footer>
  );
}

export default withStyles(styles)(StickyFooter);
