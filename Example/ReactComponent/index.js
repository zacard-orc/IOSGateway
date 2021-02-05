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
            <Text>This is a simple application.</Text>
        </View>;
    }
}
const styles = StyleSheet.create({
    container: {
        margin: 100,
        flex: 1,
        backgroundColor: 'red'
    }
});

AppRegistry.registerComponent('RNDemo', () => RNDemo);
