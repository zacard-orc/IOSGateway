import React from 'react';
import {AppRegistry, StyleSheet, View} from 'react-native';

// import Hello, {Props} from '~/components/Hello';
import Zhibo, {Props} from '~/scene/Zhibo';

const RNDemo: React.FC<Props> = () => {
  const arg = {
    name: 'bbbb',
  };
  return (
    <View style={styles.container}>
      <Zhibo {...arg} />
    </View>
  );
};
export default RNDemo;

const styles = StyleSheet.create({
  container: {
    marginLeft: 0,
    marginRight: 0,
    marginTop: 80,
    flex: 1,
    height: '100%',
    // maxHeight: 640,
    // backgroundColor: '#aaaaaa',
    borderRadius: 10,
    borderColor: '#000',
    borderWidth: 1,
  },
});

AppRegistry.registerComponent('RNDemo', () => RNDemo);
