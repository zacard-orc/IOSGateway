import React, {Component} from 'react';
import {AppRegistry, StyleSheet, Text, View} from 'react-native';

import Hello from './src/components/Hello';

export default class RNDemo extends Component {
  render() {
    return (
      <View style={styles.container}>
        {/*<Text>3333</Text>*/}
        <Hello name="aaa" />
      </View>
    );
  }
}
const styles = StyleSheet.create({
  container: {
    margin: 100,
    flex: 1,
    height: 200,
    // backgroundColor: 'grey',
  },
});

AppRegistry.registerComponent('RNDemo', () => RNDemo);

console.log('bbbb');

console.log('ccc');
