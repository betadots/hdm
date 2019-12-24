import { createMuiTheme } from '@material-ui/core/styles';

export const theme = createMuiTheme({
  palette: {
  },
  typography: {
    useNextVariants: true,
  },
  overrides: {
    MuiAppBar: {
      root: {
        boxShadow: 'unset',
        backgroundColor: "#aaa"
      }
    },
    MuiSvgIcon: { // Name of the component ⚛️ / style sheet
      root: { // Name of the rule
        color: '#000', // Some CSS
        opacity: 0.54,
      },
    },
  },
});

export default theme
