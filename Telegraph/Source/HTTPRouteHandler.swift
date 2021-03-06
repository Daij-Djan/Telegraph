//
//  HTTPRouteHandler.swift
//  Telegraph
//
//  Created by Yvo van Beek on 2/4/17.
//  Copyright © 2017 Building42. All rights reserved.
//
//  TODO: we should join all route regexes into one big regex
//  TODO: routes should first be matched on route and properly handle the case of 405 - method not allowed
//

public protocol HTTPRouteHandler: HTTPRequestHandler {
  var routes: [HTTPRoute] { get set }
}

open class HTTPRouteDefaultHandler: HTTPRouteHandler {
  public var routes = [HTTPRoute]()

  open func respond(to request: HTTPRequest, nextHandler: HTTPRequest.Handler) throws -> HTTPResponse? {
    var matchingRoute: HTTPRoute?

    for route in routes {
      // Skip routes that can't handle our method
      if !route.canHandle(methods: [request.method]) { continue }

      // Can our route handle the path?
      let (canHandle, params) = route.canHandle(path: request.uri.path)
      if !canHandle { continue }

      // We found the route, transfer the URI parameters to the request
      matchingRoute = route
      params.forEach { request.params[$0] = $1 }
      break
    }

    // If we found a route then call its handler
    if let route = matchingRoute {
      return try route.handler(request)
    }

    // Otherwise return 404 not found
    return HTTPResponse(.notFound)
  }
}
