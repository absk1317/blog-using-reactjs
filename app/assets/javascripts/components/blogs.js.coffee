@Blogs = React.createClass
  getInitialState: ->
    blogs: []

  componentDidMount: ->
    that = this
    ###
    // $.getJSON '/blogs/all', (response) ->
    //   that.setState blogs: response
    //   return
    // count = if typeof count == 'undefined' then 5 else count + 5
    // that.data = { count: count }
    ###
    $.getJSON('/blogs/all', {count: 5}).done((response) ->
      that.setState blogs: response
      that.invokePollingOfData()
      return
    ).fail (jqxhr, textStatus, error) ->
      err = textStatus + ', ' + error
      alert 'Request Failed: ' + err
      return

  invokePollingOfData: ->
    that = this
    $.getJSON('/blogs/all').done((response) ->
      that.setState blogs: response
      return
    ).fail (jqxhr, textStatus, error) ->
      err = textStatus + ', ' + error
      alert 'Request Failed: ' + err
      return

  addBlog: (blog) ->
    blogs = React.addons.update(@state.blogs, { $push: [blog] })
    @setState blogs: blogs

  deleteBlog: (blog) ->
    index = @state.blogs.indexOf blog
    blogs = React.addons.update(@state.blogs, { $splice: [[index, 1]] })
    @replaceState blogs: blogs

  updateBlog: (blog, data) ->
    index = @state.blogs.indexOf blog
    blogs = React.addons.update(@state.blogs, { $splice: [[index, 1, data]] })
    @replaceState blogs: blogs

  render: ->
    React.DOM.div
      className: 'blogs'
      React.DOM.h2
        className: 'title'
        'Blogs List'
      React.DOM.div
        className: 'blogs-down-padding'
      React.createElement BlogForm, handleNewBlog: @addBlog
      React.DOM.div
        className: 'blogs-down-padding'
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th className: 'col-md-4 center', 'Author'
            React.DOM.th className: 'col-md-4 center', 'Content'
            React.DOM.th className: 'col-md-4 center', 'Actions'
        React.DOM.tbody null,
          for blog in @state.blogs
            React.createElement Blog, key: blog.id, blog: blog, handleDeleteBlog: @deleteBlog, handleEditBlog: @updateBlog