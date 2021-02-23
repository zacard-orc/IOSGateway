import React from 'react';
import {AppRegistry, StyleSheet, Text, View} from 'react-native';

import Hello, {Props} from './src/components/Hello';

// export default class RNDemo extends Component {
//   arg = {
//     name: 'bbbb',
//   };
//   render() {
//     return (
//       <View style={styles.container}>
//         <Text>3333</Text>
//         <Hello {...this.arg} />
//       </View>
//     );
//   }
// }

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
