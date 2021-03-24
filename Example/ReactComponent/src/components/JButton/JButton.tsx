import React from 'react';
import {
  StyleSheet,
  Text,
  View,
  NativeModules,
} from 'react-native';


export interface Props {
  name: string;
  enthusiasmLevel?: number;
}

const CalendarManager = NativeModules.CalendarManager;

const JButton: React.FC<Props> = (props) => {
  const [enthusiasmLevel, setEnthusiasmLevel] = React.useState(
    props.enthusiasmLevel,
  );

  const getExclamationMarks = (numChars: number) => {
    return Array(numChars > 0 ? numChars + 1 : 0).join('!');
  };
  return (
    <View style={styles.root}>
      <Text style={styles.greeting}>
        JButton {props.name + getExclamationMarks(enthusiasmLevel || 0)}
      </Text>
    </View>
  );
};

// styles
const styles = StyleSheet.create({
  root: {
    alignItems: 'center',
    alignSelf: 'center',
  },
  buttons: {
    flexDirection: 'row',
    minHeight: 70,
    alignItems: 'stretch',
    alignSelf: 'center',
    width: 375,
    borderWidth: 1,
  },
  button: {
    flex: 1,
    paddingVertical: 0,
  },
  greeting: {
    color: 'green',
    fontWeight: 'bold',
  },
});

export default JButton;
