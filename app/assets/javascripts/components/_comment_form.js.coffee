@CommentForm = React.createClass
  getInitialState: ->
    blog_id: @props.blog.id
    content: ''
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'content'
          name: 'content'
          value: @state.content
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-success'
        disabled: !@valid()
        'Submit Comment'

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.content
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/comments', { comment: @state }, (data) =>
      @props.handleNewComment data
      @setState @getInitialState()
    , 'JSON'
