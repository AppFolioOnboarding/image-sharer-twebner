import React from 'react';
import { Alert, Button, Form, FormGroup, Label, Input } from 'reactstrap';
import { post } from '../utils/helper';

export default class FeedbackForm extends React.Component {
  constructor() {
    super();
    this.state = {
      name: '',
      comment: '',
      alertMessage: '',
      status: false
    };

    this.handleFormSubmitted = this.handleFormSubmitted.bind(this);
  }

  handleNameChange = (event) => {
    this.setState({ name: event.target.value });
  }

  handleCommentChange(event) {
    this.setState({ comment: event.target.value });
  }

  handleFormSubmitted(event) {
    event.preventDefault();
    return post('/api/feedbacks', { name: this.state.name, comment: this.state.comment })
      .then(() => {
        this.setState({
          alertMessage: 'Successfully submitted feedback!',
          status: true,
          name: '',
          comment: ''
        });
      })
      .catch(() => {
        this.setState({
          alertMessage: 'Invalid feedback!',
          status: false
        });
      });
  }

  render() {
    const { name, comment, alertMessage, status } = this.state;
    return (
      <Form className="container" onSubmit={this.handleFormSubmitted}>
        {alertMessage && <Alert color={status ? 'success' : 'warning'}>{alertMessage}</Alert>}

        <FormGroup>
          <Label for="yourName">Your name:</Label>
          <Input
            type="text"
            name="name"
            id="yourName"
            value={name}
            onChange={this.handleNameChange}
          />
        </FormGroup>
        <FormGroup>
          <Label for="commentText">Comments:</Label>
          <Input
            type="textarea"
            name="comment"
            id="commentText"
            value={comment}
            onChange={(event) => {
              this.setState({ comment: event.target.value });
            }}
          />
        </FormGroup>
        <Button color="primary">
          Submit
        </Button>
      </Form>
    );
  }
}
