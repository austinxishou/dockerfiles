#!/usr/bin/env node

const child_process = require("child_process");

const username = process.env.ALI_NPM_ACCOUNT_USR;
const password = process.env.ALI_NPM_ACCOUNT_PSW;
const email = "austindev@kulchao.com";

if (!username) {
  console.error("Please set the NPM_USER environment variable");
  process.exit(1);
}

if (!password) {
  console.error("Please set the NPM_PASS environment variable");
  process.exit(1);
}

if (!email) {
  console.error("Please set the NPM_EMAIL environment variable");
  process.exit(1);
}

const child = child_process.spawn("npm", ["login", "-q"], {
  stdio: ["pipe", "pipe", "inherit"]
});

child.stdout.on("data", d => {
  const data = d.toString();
  process.stdout.write(d + "\n");
  if (data.match(/username/i)) {
    child.stdin.write(username + "\n");
  } else if (data.match(/password/i)) {
    child.stdin.write(password + "\n");
  } else if (data.match(/email/i)) {
    child.stdin.write(email + "\n");
  } else if (data.match(/logged in as/i)) {
    child.stdin.end();
  }
});