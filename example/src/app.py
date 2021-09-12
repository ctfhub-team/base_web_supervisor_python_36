import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.httpclient


class IndexHandler(tornado.web.RequestHandler):
    def get(self):
        self.write('Hello world')


class FlagHandler(tornado.web.RequestHandler):
    def get(self):
        flag = ''
        with open('/flag', 'r') as f:
            flag = f.read()
        self.write(flag)


if __name__ == "__main__":
    app = tornado.web.Application(handlers=[
        (r"/", IndexHandler),
        (r"/flag", FlagHandler)
    ])
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(80)
    tornado.ioloop.IOLoop.instance().start()
