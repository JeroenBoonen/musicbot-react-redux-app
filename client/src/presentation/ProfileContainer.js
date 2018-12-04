import React from 'react';
import { Button, Jumbotron, Grid, Row, Col } from 'react-bootstrap'
import Profile from '../container/Profile'

function ProfileContainer (props) {
  return (
    <React.Fragment>
      <Row>
        <Button bsStyle="primary" bsSize="large" block
          onClick={props.getProfile}>
          See my song
        </Button>
      </Row>
      <Row>
        {props.profile ?
          <Jumbotron><Profile /></Jumbotron> : null}
      </Row>
    </React.Fragment>
  )
}

export default ProfileContainer
