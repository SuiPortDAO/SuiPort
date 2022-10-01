// TODO
const __globalPromiseHandlerMap = {};

function generateUUID() {
  var d = new Date().getTime();
  var d2 = ((typeof performance !== 'undefined') && performance.now && (performance.now() * 1000)) || 0;
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
    var r = Math.random() * 16;
    if (d > 0) {
      r = (d + r) % 16 | 0;
      d = Math.floor(d / 16);
    } else {
      r = (d2 + r) % 16 | 0;
      d2 = Math.floor(d2 / 16);
    }
    return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
  });
}

function createMessage(
  payload,
  id
) {
  return {
    id: id || generateUUID(),
    payload,
  };
}

const ALL_PERMISSION_TYPES = [
  'viewAccount',
  'suggestTransactions',
];

class DAppInterface {

  hasPermissions(
    permissions = ALL_PERMISSION_TYPES
  ) {
    return mapToPromise(
      this.send({
        type: 'has-permissions-request',
        permissions,
      }),
      (response) => response.result
    );
  }

  requestPermissions(
    permissions = ALL_PERMISSION_TYPES
  ) {
    return mapToPromise(
      this.send({
        type: 'acquire-permissions-request',
        permissions,
      }),
      (response) => response.result
    );
  }

  getAccounts() {
    return mapToPromise(
      this.send({
        type: 'get-account',
      }),
      (response) => response.accounts
    );
  }

  executeMoveCall(transaction) {
    return mapToPromise(
      this.send({
        type: 'execute-transaction-request',
        transaction,
      }),
      (response) => response.result
    );
  }

  executeSerializedMoveCall(transactionBytes) {
    return mapToPromise(
      this.send({
        type: 'execute-transaction-request',
        transactionBytes,
      }),
      (response) => response.result
    );
  }

  send(
    payload,
    responseForID
  ) {
    const msg = createMessage(payload, responseForID);
    Promise.resolve().then(function () {
      window.__SpMessageProxy(JSON.stringify(msg));
    });
    return msg.id;
  }
}


function mapToPromise(responseForID, project) {
  return new Promise((resolve, reject) => {
    __globalPromiseHandlerMap[responseForID] = {
      resolve,
      reject,
      project
    };
  })
}

function __SpMessageProxyCallback(response, msgId) {
  response = JSON.parse(response);
  const promiseHandler = __globalPromiseHandlerMap[msgId];
  if(!promiseHandler) {
    return;
  }
  if (isErrorPayload(response)) {
    promiseHandler.reject(response.message);
  } else {
    promiseHandler.resolve(promiseHandler.project(response))
  }
  delete __globalPromiseHandlerMap[msgId];
}

function isErrorPayload(payload) {
  return 'error' in payload && payload.error === true;
}

Object.defineProperty(window, 'suiWallet', {
  enumerable: false,
  configurable: false,
  value: new DAppInterface(),
});