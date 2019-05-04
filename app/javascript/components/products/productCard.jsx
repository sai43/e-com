import React, {Component} from 'react'
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import classnames from 'classnames';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import CardMedia from '@material-ui/core/CardMedia';
import CardContent from '@material-ui/core/CardContent';
import CardActions from '@material-ui/core/CardActions';
import Collapse from '@material-ui/core/Collapse';
import Avatar from '@material-ui/core/Avatar';
import IconButton from '@material-ui/core/IconButton';
import Typography from '@material-ui/core/Typography';
import red from '@material-ui/core/colors/red';
import FavoriteIcon from '@material-ui/icons/Favorite';
import ShareIcon from '@material-ui/icons/Share';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import MoreVertIcon from '@material-ui/icons/MoreVert';
import Button from '@material-ui/core/Button';
import moment from 'moment';

const styles = theme => ({
    card: {
        maxWidth: 890,
    },
    media: {
        height: 0,
        paddingTop: '56.25%', // 16:9
    },
    actions: {
        display: 'flex',
    },
    expand: {
        transform: 'rotate(0deg)',
        marginLeft: 'auto',
        transition: theme.transitions.create('transform', {
            duration: theme.transitions.duration.shortest,
        }),
    },
    expandOpen: {
        transform: 'rotate(180deg)',
    },
    avatar: {
        backgroundColor: red[500],
    },
    button: {
        margin: '5px'
    },
    title: {
        fontSize: '20px',
        fontWeight: 'bold'
    }
});

class ProductCard extends Component {

    constructor(props) {
        super(props);
        this.state = {
            product: props.product,
            expanded: false,
            anchorEl: null,
        };
    }

    handleExpandClick = () => {
        this.setState(state => ({ expanded: !state.expanded }));
    };

    render() {
        const { classes, product } = this.props;
        const { anchorEl } = this.state;
        return (
            <Card className={classes.card}>
                <CardHeader
                    avatar={
                        <Avatar aria-label="product" className={classes.avatar}>
                            E
                        </Avatar>
                    }
                    action={
                        <IconButton>
                            <MoreVertIcon />
                            <FavoriteIcon />
                            <ShareIcon />
                        </IconButton>
                    }
                />
                <CardMedia
                    className={classes.media}
                    image= { product.product_images.length > 0 ? product.product_images[0].medium.url : '/phone.jpg'}
                    title={ product.title }
                />
                <CardContent>
                    <Typography className={classes.title}>{ product.title }</Typography>
                    <Typography> { moment(product.updated_at).format('MMMM-DD-YYYY')} </Typography>
                    <Typography component="p">Black Strap, size regular</Typography>
                </CardContent>

                <CardActions className={classes.actions} disableActionSpacing>
                    <Button variant="contained" color="primary" className={classes.button}>
                        Add to cart
                    </Button>
                    <Button variant="contained" color="secondary" className={classes.button}>
                        Book now
                    </Button>
                    <IconButton
                        className={classnames(classes.expand, {
                            [classes.expandOpen]: this.state.expanded,
                        })}
                        onClick={this.handleExpandClick}
                        aria-expanded={this.state.expanded}
                        aria-label="Show more"
                    >
                        <ExpandMoreIcon />
                    </IconButton>
                </CardActions>
                <Collapse in={this.state.expanded} timeout="auto" unmountOnExit>
                    <CardContent>
                        <Typography paragraph>Method:</Typography>
                        <Typography paragraph>
                            Heat 1/2 cup of the broth in a pot until simmering, add saffron and set aside for 10
                            minutes.
                        </Typography>
                    </CardContent>
                </Collapse>
            </Card>
        );
    }
}

ProductCard.propTypes = {
    classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(ProductCard);

