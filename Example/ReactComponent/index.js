import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View
} from 'react-native';
export default class RNDemo extends Component {
    render() {
        return <View style={styles.container}>
            <Text>Red</Text>
        </View>;
    }
}
const styles = StyleSheet.create({
    container: {
        margin: 100,
        flex: 1,
        backgroundColor: 'grey'
    }
});

AppRegistry.registerComponent('RNDemo', () => RNDemo);
