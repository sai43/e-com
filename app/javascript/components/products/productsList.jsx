import React, {Component} from 'react'
import PropTypes from 'prop-types';
import ProductCard from './productCard'
import { withStyles } from '@material-ui/core/styles';
import GridList from '@material-ui/core/GridList';
// import GridListTile from '@material-ui/core/GridListTile';
// import GridListTileBar from '@material-ui/core/GridListTileBar';
// import IconButton from '@material-ui/core/IconButton';
// import StarBorderIcon from '@material-ui/icons/StarBorder';
// import tileData from './tileData';

const styles = theme => ({
    root: {
        display: 'flex',
        flexWrap: 'wrap',
        justifyContent: 'space-around',
        overflow: 'hidden',
        backgroundColor: theme.palette.background.paper,
    },
    gridList: {
        flexWrap: 'nowrap',
        // Promote the list into his own layer on Chrome. This cost memory but helps keeping high FPS.
        transform: 'translateZ(0)',
        width: 960,
        height: 600,
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
                <GridList cellHeight={160} className={classes.gridList} cols={3}>
                    { products.map((item, index )=>(
                        <ProductCard key={index} product={item} />
                    ))}
                </GridList>
            </div>
        );
    }

}

ProductsList.propTypes = {
    classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(ProductsList);