import React from 'react';
import PropTypes from 'prop-types';
import { socialMedia } from '@config';
import { Side } from '@components';
import { FormattedIcon } from '@components/icons';
import styled from 'styled-components';
import { theme } from '@styles';
const { colors } = theme;

const StyledList = styled.ul`
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0;
  margin: 0;
  list-style: none;

  &:after {
    content: '';
    display: block;
    width: 1px;
    height: 90px;
    margin: 0 auto;
    background-color: ${colors.lightSlate};
  }

  li:last-of-type {
    margin-bottom: 20px;
  }
`;
const StyledLink = styled.a`
  padding: 10px;
  &:hover,
  &:focus {
    transform: translateY(-3px);
  }
  svg {
    width: 38px;
    height: 38px;
  }
  img {
    width: 48px;
    height: 48px;
    float: right;
    max-width: 100%;
    margin-left: 50px;
    margin-right: auto;
    background:none;
  }
  // TODO: update images/icons/medium.png before uncommenting
  // img:hover{
  //   background:#64ffda;
  // }
`;

const Social = ({ isHome }) => (
  <Side isHome={isHome} orientation="left">
    <StyledList>
      {socialMedia &&
        socialMedia.map(({ url, name }, i) => (
          <li key={i}>
            <StyledLink
              href={url}
              target="_blank"
              rel="nofollow noopener noreferrer"
              aria-label={name}>
              <FormattedIcon name={name} />
            </StyledLink>
          </li>
        ))}
    </StyledList>
  </Side>
);

Social.propTypes = {
  isHome: PropTypes.bool,
};

export default Social;
