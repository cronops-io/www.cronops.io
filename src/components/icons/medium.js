import React from 'react';
import icon from '../../images/icons/medium.png'; // Tell webpack this JS file uses this image

const IconMedium = () => <img src={icon} alt="medium"/>;

export default IconMedium; // Depends on | 1. src/components/icons/formattedIcon.js & 2. src/components/icons/index.js
