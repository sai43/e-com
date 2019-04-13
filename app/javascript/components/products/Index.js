import React from "react"
import PropTypes from "prop-types"
import Product from './Product'

class Index extends React.Component {
  render () {
    return (
      <React.Fragment>

      { this.props.products.map((product) => (
          < Product key={product.id} product={product} />
      ))
      }

    </React.Fragment>
    );
  }
}

Index.propTypes = {
    products: PropTypes.array
};

export default Index
