/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
  NativeModules,
  NativeAppEventEmitter,
} from 'react-native';
var CalendarManager = NativeModules.CalendarManager;

class RNAndOC extends Component {
  componentDidMount() {
        // console.log('开始订阅通知...');
        // subscription = NativeAppEventEmitter.addListener(
        //     'EventReminder',
        //     (reminder) => console.log('通知信息:'+reminder.name)
        // );
  }
  buttonClickACtion = () => {
    console.log('开始订阅通知...');
        subscription = NativeAppEventEmitter.addListener(
            'EventReminder',
            (reminder) => {
              console.log('通知信息:'+reminder.name)
              subscription.remove()
            }
        );
    CalendarManager.sendNotification('准备发送通知...')
  }
  render() {
    return (
      <View style={styles.container}>
          <CustomButton text="点击调用原生模块sendNotification方法"
              onPress={()=>this.buttonClickACtion()}/>
      </View>
    );
  }
}
class CustomButton extends React.Component {
    render() {
        return (
            <TouchableHighlight
                style={styles.button}
                underlayColor="#a5a5a5"
                onPress={this.props.onPress}>
                <Text style={styles.buttonText}>{this.props.text}</Text>
            </TouchableHighlight>
        );
    }
}
const styles = StyleSheet.create({
  container: {
    marginTop:20,
    backgroundColor:'red',
  },
  button:{
    margin:5,
    backgroundColor:'white',
    padding:10,
    borderWidth:1,
    borderColor:'#cdcdcd',
  },
  buttonText:{
    textAlign:'center',
  },
});

AppRegistry.registerComponent('RNAndOC', () => RNAndOC);
