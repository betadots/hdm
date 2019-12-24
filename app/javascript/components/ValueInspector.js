import React, { useState } from "react";
import { withStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import Editable from "./Editable";

const styles = theme => ({
  root: {
    width: "100%"
  },
  heading: {
    fontSize: theme.typography.pxToRem(15),
    fontWeight: theme.typography.fontWeightRegular
  },
  disabledPanel: {
    backgroundColor: "rgb(229, 229, 229)"
  },
  textField: {
    width: "100%"
  }
});

function ValueInspector({ classes, model, data, keyData }) {
  return (
    <div className={classes.root}>
      {Object.keys(keyData).map(hierarchy => {
        return (
          <div key={hierarchy}>
            <Typography className={classes.heading}>{hierarchy}</Typography>
            {keyData[hierarchy].map(file => {
              return (
                <Editable
                  model={model}
                  key={`${hierarchy}-${file.path}`}
                  hierarchy={hierarchy}
                  file={file}
                />
              );
            })}
          </div>
        );
      })}
    </div>
  );
}

export default withStyles(styles)(ValueInspector);
