'use strict'

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app
  router.get('/', controller.home.index)
  // admin
  router.get('/admin.html', controller.admin.index)
  router.post('/admin/create.json', controller.admin.create)
  router.post('/admin/remove.json', controller.admin.remove)
}
