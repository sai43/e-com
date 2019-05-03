import React, {Component} from 'react'
import PropTypes from 'prop-types';
import ProductCard from './productCard'
import { withStyles } from '@material-ui/core/styles';
import Grid from '@material-ui/core/Grid';
import Login from '../sessions/new'

const styles = theme => ({
    root: {
        display: 'flex',
        flexWrap: 'wrap',
        justifyContent: 'space-around',
        overflow: 'hidden',
        backgroundColor: theme.palette.background.paper,
    },
    title: {
        color: theme.palette.primary.light,
    },
    titleBar: {
        background:
            'linear-gradient(to top, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.3) 70%, rgba(0,0,0,0) 100%)',
    },
});

class ProductsList extends  Component {

    state = {
        products: []
    };

    componentDidMount(){
        this.getAllProducts();
    }

    getAllProducts = () => {
        $.getJSON('/api/v1/products/index', (response) => { this.setState({ products: response }) });
    };

    render () {
        const { classes } = this.props;
        const products = this.state.products;
        return (
            <div className={classes.root}>
                <Login/>
                <Grid container spacing={24} style={{padding: 24}}>
                    { products.map((currentProduct, index )=>(
                        <Grid item xs={12} sm={6} lg={4} xl={3}>
                            <ProductCard key={index} product={currentProduct} />
                        </Grid>
                    ))}
                </Grid>
            </div>
        );
    }

}

ProductsList.propTypes = {
    classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(ProductsList);