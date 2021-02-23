module.exports = {
  devices: {
    simulator: {
      type: 'ios.simulator',
      device: {
        type: 'iPhone 8',
      },
    },
  },
  configurations: {
    'ios.sim.debug': {
      device: 'simulator',
      app: 'com.bankcomm.apns.new',
    },
  },
};
