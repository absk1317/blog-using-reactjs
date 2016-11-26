@Comment = React.createClass
  getInitialState: ->
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleEdit: (e) ->
    e.preventDefault()
    data =
      content: ReactDOM.findDOMNode(@refs.content).value
    $.ajax
      method: 'PUT'
      url: "/comments/#{ @props.comment.id }"
      dataType: 'JSON'
      data:
        comment: data
      success: (data) =>
        @setState edit: false
        @props.handleEditComment @props.comment, data

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/comments/#{ @props.comment.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteComment @props.comment

  render: ->
    if @state.edit
      @commentForm()
    else
      @commentRow()

  commentRow: ->
    React.DOM.tr null,
      React.DOM.td className: 'col-md-4 center', @props.comment.content
      React.DOM.td className: 'col-md-4 center',
        React.DOM.a
          className: 'btn btn-warning'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'

  commentForm: ->
    React.DOM.tr null,
      React.DOM.td className: 'col-md-4 center',
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.comment.content
          ref: 'content'
      React.DOM.td className: 'col-md-4 center',
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'
