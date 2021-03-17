/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import FeedbackForm from '../../components/FeedbackForm';

describe('<FeedbackForm />', () => {
  it('should render correctly', () => {
    const wrapper = mount(<FeedbackForm />);

    const feedbackForm = wrapper.find('Form');
    assert.strictEqual(feedbackForm.length, 1);

    const nameLabel = feedbackForm.find('Label').at(0);
    assert.strictEqual(nameLabel.length, 1);
    assert.strictEqual(nameLabel.text(), 'Your name:');

    const commentLabel = feedbackForm.find('Label').at(1);
    assert.strictEqual(commentLabel.length, 1);
    assert.strictEqual(commentLabel.text(), 'Comments:');

    const button = feedbackForm.find('Button');
    assert.strictEqual(button.length, 1);
    assert.strictEqual(button.text(), 'Submit');
    assert.strictEqual(button.props().color, 'primary');
  });
});
