#include <QMainWindow>
#include <QMessageBox>
#include <QObject>
#include "bar/bar.h"

class Message : public QObject
{
    Q_OBJECT
public slots:
    void onGo()
    {
        QMessageBox(
            QMessageBox::Icon::Information,
            "bar output",
            QString::fromStdString(bar()),
            QMessageBox::StandardButton::NoButton,
            nullptr).exec();
    }
};
