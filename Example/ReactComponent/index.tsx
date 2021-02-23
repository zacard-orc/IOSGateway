import React from 'react';
import {AppRegistry, StyleSheet, Text, View} from 'react-native';

import Hello, {Props} from '~/components/Hello';

const RNDemo: React.FC<Props> = () => {
  const arg = {
    name: 'bbbb',
  };
  return (
    <View style={styles.container}>
      <Text>3333</Text>
      <Hello {...arg} />
    </View>
  );
};
export default RNDemo;

const styles = StyleSheet.create({
  container: {
    marginLeft: 10,
    marginRight: 10,
    marginTop: 100,
    flex: 1,
    maxHeight: 140,
    backgroundColor: '#aaaaaa',
    borderRadius: 10,
  },
});

AppRegistry.registerComponent('RNDemo', () => RNDemo);
