import PropTypes from 'prop-types';
import React from 'react';

export default function Footer(props) {
  const { message } = props;
  return (
    <footer className='text-center'>{message}</footer>
  );
}

Footer.propTypes = {
  message: PropTypes.string.isRequired
};
