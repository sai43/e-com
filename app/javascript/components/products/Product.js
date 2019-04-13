import React from "react"
import PropTypes from "prop-types"
class Product extends React.Component {
  render () {
      debugger
    return (
      <React.Fragment>
         <li> { this.props.product.title } </li>
      </React.Fragment>
    );
  }
}

Product.propTypes = {
  product: PropTypes.object
};
export default Product
