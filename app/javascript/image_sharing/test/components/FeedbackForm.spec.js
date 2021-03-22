/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import sinon from 'sinon';
import FeedbackForm from '../../components/FeedbackForm';
import * as helper from '../../utils/helper';

describe('<FeedbackForm />', () => {
  afterEach(() => {
    sinon.restore();
  });

  it('should render correctly', () => {
    const wrapper = shallow(<FeedbackForm />);

    const feedbackForm = wrapper.find('Form');
    assert.strictEqual(feedbackForm.length, 1);

    const alert = wrapper.find('Alert');
    assert.strictEqual(alert.length, 0);

    const nameLabel = feedbackForm.find('Label').at(0);
    assert.strictEqual(nameLabel.length, 1);
    assert.strictEqual(nameLabel.children().text(), 'Your name:');

    const commentLabel = feedbackForm.find('Label').at(1);
    assert.strictEqual(commentLabel.length, 1);
    assert.strictEqual(commentLabel.children().text(), 'Comments:');

    const button = feedbackForm.find('Button');
    assert.strictEqual(button.length, 1);
    assert.strictEqual(button.children().text(), 'Submit');
    assert.strictEqual(button.props().color, 'primary');
  });

  it('should submit valid feedback correctly and display success alert', async () => {
    const wrapper = shallow(<FeedbackForm />);
    const name = 'Tyler';
    const comment = 'This is awesome';

    wrapper.setState({ name, comment });

    const postStub = sinon.stub(helper, 'post').resolves();
    await wrapper.instance().handleFormSubmitted({
      preventDefault: () => {
      } });
    assert(postStub.calledOnceWith('/api/feedbacks', { name, comment }));

    assert.strictEqual(wrapper.state().alertMessage, 'Successfully submitted feedback!');
    assert(wrapper.state().status);
    assert(!wrapper.state().name);
    assert(!wrapper.state().comment);

    const alert = wrapper.find('Alert');
    assert.strictEqual(alert.length, 1);
    assert.strictEqual(alert.props().color, 'success');

    const nameInput = wrapper.find('Input').at(0);
    assert.strictEqual(nameInput.length, 1);
    assert.strictEqual(nameInput.props().value, '');

    const commentInput = wrapper.find('Input').at(1);
    assert.strictEqual(commentInput.length, 1);
    assert.strictEqual(commentInput.props().value, '');
  });

  it('should submit invalid feedback correctly and display warning alert', async () => {
    const wrapper = shallow(<FeedbackForm />);
    const name = '';
    const comment = 'This is awesome';

    wrapper.setState({ name, comment });

    const postStub = sinon.stub(helper, 'post').rejects();
    await wrapper.instance().handleFormSubmitted({
      preventDefault: () => {
      } });
    assert(postStub.calledOnceWith('/api/feedbacks', { name, comment }));

    assert(!wrapper.state().status);
    assert.strictEqual(wrapper.state().name, name);
    assert.strictEqual(wrapper.state().comment, comment);
    assert.strictEqual(wrapper.state().alertMessage, 'Invalid feedback!');

    const alert = wrapper.find('Alert');
    assert.strictEqual(alert.length, 1);
    assert.strictEqual(alert.props().color, 'warning');

    const nameInput = wrapper.find('Input').at(0);
    assert.strictEqual(nameInput.length, 1);
    assert.strictEqual(nameInput.props().value, name);

    const commentInput = wrapper.find('Input').at(1);
    assert.strictEqual(commentInput.length, 1);
    assert.strictEqual(commentInput.props().value, comment);
  });
});
