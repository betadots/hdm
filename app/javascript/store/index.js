import { createStore } from 'redux'
import { combineReducers } from 'redux'

const DRAWER_OPEN = 'DRAWER_OPEN'
const DRAWER_CLOSE = 'DRAWER_CLOSE'

function drawer(state = { open: true }, action) {
  switch (action.type) {
    case DRAWER_OPEN:
      return {...action.props, open: true}
    case DRAWER_CLOSE:
    return {...action.props, open: false}
    default:
      return state
  }
}

const rootReducer = combineReducers({
  drawer,
})

const store = createStore(rootReducer)

export default store
