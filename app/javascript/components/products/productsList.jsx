import React, {Component} from 'react'

import Card from './card'

class ProductsList extends  Component {

    state = {
        products: []
    };

    componentDidMount(){
        this.getAllProducts();
    }

    getAllProducts = () => {
        const csrfToken = document.querySelector('meta[name=csrf-token]').getAttribute('content');
        fetch('/graphql', {
            method: 'POST',
            headers: {'content-type': 'application/json', 'X-CSRF-Token': csrfToken},
            body: JSON.stringify(
                { query: `
                    query {
                          products {
                            id
                            title
                            price
                          }  
                        }
                ` })
        }).then(response => {
            return response.json()
        }).then(response => {
            this.setState({products: response.data.products})
        })
    };

    render () {
        const products = this.state.products;
        return (
          <div>
              <Card />
              {products.map((product, index )=>( <h2>{ product.title } - { product.price }</h2> ))}
          </div>
        );
    }

}

export default ProductsList;