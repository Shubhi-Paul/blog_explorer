const String getBlogsQuery = r'''
 query MyQuery {
  getSections(request: {id: "42b0ee58-2303-4178-a1f7-f2786298f68d"}) {
    image_url
    title
    id
    }
  }
  ''';