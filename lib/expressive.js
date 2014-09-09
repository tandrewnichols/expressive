module.exports = function(app, options) {
  // Options setup
  var opts = Array.isArray(options) || typeof options === 'string' ? { envs: options } : options || {};
  opts.envs = typeof opts.envs === 'string' ? [opts.envs] : (opts.envs && opts.envs.length ? opts.envs : ['development']);
  opts.env = opts.env || process.env.NODE_ENV;
  opts.alias = opts.alias || {};

  // Add hooks for each environment
  opts.envs.forEach(function(env) {
    var prop = opts.alias[env] || env;
    app[prop] = {
      use: function() {
        if (opts.env === env) {
          app.use.apply(app, arguments);
        }
      }
    };
  });
};
