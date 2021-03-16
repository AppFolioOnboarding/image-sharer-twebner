import React from 'react';
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';

export default function FeedbackForm() {
  return (
    <Form className="container">
      <FormGroup>
        <Label for="yourName">Your name:</Label>
        <Input type="text" name="name" id="yourName" />
      </FormGroup>
      <FormGroup>
        <Label for="commentText">Comments:</Label>
        <Input type="textarea" name="comment" id="commentText" />
      </FormGroup>
      <Button color="primary">Submit</Button>
    </Form>
  );
}
