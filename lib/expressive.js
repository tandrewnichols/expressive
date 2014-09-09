var _ = require('lodash');

module.exports = function(app, options, env) {
  // Options setup
  var opts = Array.isArray(options) || typeof options === 'string' ? { envs: options } : options || {};
  opts.envs = typeof opts.envs === 'string' ? [opts.envs] : (opts.envs && opts.envs.length ? opts.envs : ['development']);
  opts.env = env || opts.env || process.env.NODE_ENV;
  opts.alias = opts.alias || {};

  // Add hooks for each environment
  opts.envs.forEach(function(env) {
    var prop = opts.alias[env] || env;
    app[prop] = {};
    _(app).functions().each(function(func) {
      app[prop][func] = function() {
        if (opts.env === env) {
          app[func].apply(app, arguments);
        }
      };
    });
  });
};
