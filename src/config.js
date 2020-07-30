module.exports = {
  siteTitle: 'Cronops | DevOps Enablement Open Source Initiative',
  siteDescription:
    'Open Source initiative to bring DevOps culture and software development best practices closer to the community. Our purpose is to contribute to both building and scaling high-performance technology organizations.',
  siteKeywords:
    'CronOps, organizational culture, devops, devsecops, sdlc, best practices',
  siteUrl: 'https://www.cronops.io',
  siteLanguage: 'en_US',
  googleAnalyticsID: 'UA-XXXXXXXXX-2',
  googleVerification: 'DCl7VAf9tcz6eDxxxxxxxxxxxxxxxxxxxxxx',
  name: 'Cronops',
  location: 'Cordoba, AR',
  email: 'info@cronops.io',
  github: 'https://github.com/cronops-io',
  socialMedia: [
    {
      name: 'GitHub',
      url: 'https://github.com/cronops-io',
    },
    {
      name: 'Linkedin',
      url: 'https://www.linkedin.com/company/cronops',
    },
    {
      name: 'Medium',
      url: 'https://medium.com/cronops',
    },
  ],

  navLinks: [
    {
      name: 'About',
      url: '/#about',
    },
    {
      name: 'Products',
      url: '/#projects',
    },
    {
      name: 'Related Projects',
      url: '/#related-projects',
    },
    {
      name: 'Contact',
      url: '/#contact',
    },
  ],

  navHeight: 100,

  colors: {
    green: '#64ffda',
    navy: '#0a192f',
    darkNavy: '#020c1b',
  },

  srConfig: (delay = 200) => ({
    origin: 'bottom',
    distance: '20px',
    duration: 500,
    delay,
    rotate: { x: 0, y: 0, z: 0 },
    opacity: 0,
    scale: 1,
    easing: 'cubic-bezier(0.645, 0.045, 0.355, 1)',
    mobile: true,
    reset: false,
    useDelay: 'always',
    viewFactor: 0.25,
    viewOffset: { top: 0, right: 0, bottom: 0, left: 0 },
  }),
};
