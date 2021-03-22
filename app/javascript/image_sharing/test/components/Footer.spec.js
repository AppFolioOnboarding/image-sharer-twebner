/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import Footer from '../../components/Footer';

describe('<Footer />', () => {
  it('should render correctly', () => {
    const wrapper = mount(<Footer message="Test message" />);
    const footer = wrapper.find('footer');

    assert.strictEqual(footer.length, 1);
    assert.strictEqual(footer.text(), 'Test message');
    assert.strictEqual(footer.prop('className'), 'text-center');
  });
});
