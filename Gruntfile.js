module.exports = (grunt) => {
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-mocha-test')
  grunt.loadNpmTasks('grunt-travis-matrix')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-simple-istanbul')
  grunt.loadNpmTasks('grunt-open')

  grunt.initConfig({
    jshint: {
      options: {
        reporter: require('jshint-stylish'),
        eqeqeq: true,
        esversion: 6,
        indent: true,
        newcap: true,
        quotmark: 'single',
        boss: true,
        asi: true
      },
      all: ['lib/**/*.js']
    },
    istanbul: {
      cover: {
        options: {
          hookRunInContext: true,
          root: 'lib',
          dir: 'coverage',
          x: ['**/node_modules/**'],
          simple: {
            args: ['grunt', 'mochaTest:test']
          }
        }
      }
    },
    mochaTest: {
      options: {
        reporter: 'spec',
        ui: 'mocha-given',
        require: 'coffee-script/register'
      },
      test: {
        src: ['test/**/*.coffee']
      }
    },
    travisMatrix: {
      v4: {
        test: () => {
          return /^v4/.test(process.version)
        },
        tasks: ['istanbul:cover', 'shell:codeclimate']
      }
    },
    shell: {
      codeclimate: 'codeclimate-test-reporter < coverage/lcov.info'
    },
    open: {
      coverage: {
        path: 'coverage/lcov-report/index.html'
      }
    }
  });

  grunt.registerTask('mocha', ['mochaTest:test'])
  grunt.registerTask('default', ['jshint:all', 'mocha'])
  grunt.registerTask('coverage', ['istanbul:cover'])
  grunt.registerTask('ci', ['jshint:all', 'mocha', 'travisMatrix:v4'])
}
