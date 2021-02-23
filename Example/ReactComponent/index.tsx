import React, {Component} from 'react';
import {AppRegistry, StyleSheet, Text, View} from 'react-native';

export default class RNDemo extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>Red11</Text>
      </View>
    );
  }
}
const styles = StyleSheet.create({
  container: {
    margin: 100,
    flex: 1,
    backgroundColor: 'grey',
  },
});

AppRegistry.registerComponent('RNDemo', () => RNDemo);

console.log('bbbb');

console.log('ccc');
