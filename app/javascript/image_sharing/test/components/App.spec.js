/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import App from '../../components/App';

describe('<App />', () => {
  it('should render correctly', () => {
    const wrapper = mount(<App />);

    const header = wrapper.find('Header');
    assert.strictEqual(header.length, 1);
    assert.strictEqual(header.props().title, 'Tell us what you think');

    const feedbackForm = wrapper.find('FeedbackForm');
    assert.strictEqual(feedbackForm.length, 1);

    const footer = wrapper.find('Footer');
    assert.strictEqual(footer.length, 1);
    assert.strictEqual(footer.props().message, 'Copyright: AppFolio Inc. Onboarding');
  });
});
